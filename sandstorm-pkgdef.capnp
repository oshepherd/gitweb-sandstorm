@0xdd64070b2a0a30f9;

using Spk = import "/sandstorm/package.capnp";
using Util = import "/sandstorm/util.capnp";

const pkgdef :Spk.PackageDefinition = (
  id = "vfqrxpcsgpuz5cgxu63vj241zj8kq6pe60ck0uguxggzkm4yx260",
  # Your app ID is actually its public key. The private key was placed in
  # your keyring. All updates must be signed with the same key.

  manifest = (
    appTitle = (defaultText = "GitWeb Pages"),
    appVersion = 6,  # Increment this for every release.
    appMarketingVersion = (defaultText = "0.0.6-asheesh"),

    actions = [
      ( title = (defaultText = "New GitWeb Pages Repository"),
        command = .startCommand
      )
    ],

    continueCommand = .continueCommand
  ),

  sourceMap = (
    searchPath = [
      ( sourcePath = "." ),  # Search this directory first.
      ( sourcePath = "/",    # Then search the system root directory.
        hidePaths = [ "home", "proc", "sys",
                      "etc/nsswitch.conf", "etc/passwd", "etc/shadow", "etc/ssl/openssl.cnf"]
      )
    ]
  ),

  fileList = "sandstorm-files.list",

  alwaysInclude = [],

  bridgeConfig = (
    viewInfo = (
      permissions = [(name = "read", title = (defaultText = "read"),
                      description = (defaultText = "allows `git fetch`")),
                     (name = "write", title = (defaultText = "write"),
                      description = (defaultText = "allows `git push`"))],
      roles = [(title = (defaultText = "guest"),
                permissions = [true, false],
                verbPhrase = (defaultText = "can read")),
               (title = (defaultText = "developer"),
                permissions = [true, true],
                verbPhrase = (defaultText = "can read and write"),
                default = true)]
    ),
    apiPath = "/repo.git/"
  )
);

const commandEnvironment : List(Util.KeyValue) =
  [
    (key = "PATH", value = "/usr/local/bin:/usr/bin:/usr/sbin:/bin")
  ];

const startCommand :Spk.Manifest.Command = (
  argv = ["/sandstorm-http-bridge", "10000", "--", "/bin/sh", "start.sh"],
  environ = .commandEnvironment
);


const continueCommand :Spk.Manifest.Command = (
  argv = ["/sandstorm-http-bridge", "10000", "--", "/bin/sh", "continue.sh"],
  environ = .commandEnvironment
);
