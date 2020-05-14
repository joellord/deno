# Use Deno in a container
Do you want to run your Deno file in the cloud? Or do you simply want to test it out without installing the executable? The simplest way is by running it in a container.

## Start the container
You can start the container in a similar way you would for a NodeJS container. Just use the [deno image](http://github.com/joellord/deno).

```
docker run joellord/deno
```

This should output the currently used version of Deno.

## Run a Deno script
You can run a deno script by using the deno tool as part of your `docker run` command. You should map your JS/TS files to a mounted volume so they can be accessed from within the container.

```
echo "hello world" > demo.js
docker run -v $(pwd):/app joellord/deno deno run /app/demo.js
```

## Run a simple Deno web server
To run the demo web server from the [Deno documentation](https://deno.land/#getting-started), you can start by creating your server.ts file using the following TypeScript.

```
import { serve } from "https://deno.land/std@0.50.0/http/server.ts";
const s = serve({ port: 8000 });
console.log("http://localhost:8000/");
for await (const req of s) {
  req.respond({ body: "Hello World\n" });
}
```

And then run it from the container. Don't forget to map the ports so the server can be accessed from your local machine. You will also need to add the `--allow-net` flag in order to let Deno start the web server.

```
docker run -v $(pwd):/app -p 8000:8000 joellord/deno deno run --allow-net /app/server.ts
```

You can also run the server in detached mode using the `-d` flag in Docker.
```
docker run -v $(pwd):/app -p 8000:8000 -d joellord/deno deno run --allow-net /app/server.ts
```

## Automatically start JS/TS files
When the container is started, it will automatically look into the /deno-entrypoint for any JavaScript or TypeScript files and will automatically run them. This can be useful to automatically run a JS/TS file at start-up. Those scripts are only executed with the `deno run` command and won't pass in any flags.

```
docker run -v $(pwd):/deno-entrypoint joellord/deno
```