This project is a Anaconda repository of packages developed or customized for
USGS Astrogeology Science Center.

These packages include:
* gdal (with support for kakadu)
* kakadu (licensed software for jpeg2000)
* geotiff (with support for proj4 >=4.9.2 as required by gdal 2.2.0)

## Build and Install

To build the kakadu package you will need to
* create a tar.gz archive of your licensed kakadu src distribution.
* Then edit the meta.yaml file in the kakadu folder of this repo with the archive location and the md5sum of the archive.

To do this, try running:

```
tar -zcvf kakadu-version.tar.gz /path/to/mykakadu_dir
md5sum kakadu-version.tar.gz
```

To use this repository, 

* you will nedd to build the packages of each subdirectory
* you will need to create a local custom channel
* then add this channel to specify it as the source for these packages.
* and finally use `conda install <pkgname>` to install the packages.

You can run the `create_channel.sh` script in this repo to build the packages and add the channel for you.

or

Do it mannually:

```
conda build --output-folder <path to channel> kakadu
conda build --output-folder <path to channel>  gdal
conda build --output-folder <path to channel>  geotiff
conda config --add channels <path to channel> 
```

Here is the anaconda doc on creating custom channels: [https://conda.io/docs/custom-channels.html](https://conda.io/docs/custom-channels.html)
