This project is a Anaconda repository of packages developed or customized for
USGS Astrogeology Science Center.

These packages include:
* gdal (with support for kakadu)
* kakadu (licensed software for jpeg2000)
* geotiff (with support for proj4 >=4.9.2 as required by gdal 2.2.0)

To build kakadu you will need to create a tar.gz archive of the kakadu src distribution and edit the meta.yaml file in the kakadu folder to reflect its location and md5sum.
Try running:

```
tar -zcvf kakadu-version.tar.gz /path/to/mykakadu_dir
md5sum kakadu-version.tar.gz
```

To use this repository, you will need to create a local custom channel and specify it as the source for these packages.

You can run the `create_channel.sh` script in this repo to build the packages and add the channel for you.

or

Do it mannually:

```
conda build --output-folder <path to channel> kakadu
conda build --output-folder <path to channel>  gdal
```

Now follow the instructions on creating custom channels: [https://conda.io/docs/custom-channels.html](https://conda.io/docs/custom-channels.html)
