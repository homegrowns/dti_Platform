module.exports = {
  apps: [
    {
      name: "DTIAI Rest API",
      cwd: "/data/backend/src",
      script: "yarn",
      args: "run prod",
      watch: true,
      autorestart: true,
      exec_mode: "cluster",
      instances: "1",
      ignore_watch: ["node_modules", "logs", "download-file"],
    },
  ],
};
