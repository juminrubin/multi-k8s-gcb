const keys = require("./keys");
const redis = require("redis");

const redisClient = redis.createClient({
  host: keys.redisHost,
  port: keys.redisPort,
  retry_strategy: () => 1000,
});
const redisSub = redisClient.duplicate();

function fib(index) {
  if (index < 2) return 1;

  return fib(index - 1) + fib(index - 2);
}

redisSub.on("message", (channel, message) => {
  redisClient.hset("values", message, fib(parseInt(message)));
});
redisSub.subscribe("insert");
