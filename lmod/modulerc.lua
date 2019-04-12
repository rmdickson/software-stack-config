-- default versions
if os.getenv("EBVERSIONSTDENV") == "2018.3" then
	module_version("boost/1.68.0","default")
	module_version("boost-mpi/1.68.0","default")
	module_version("imkl/2018.3.222","default")
	module_version("intel/2018.3","default")
	module_version("openmpi/3.1.2","default")
	module_version("gcc/7.3.0","default")
	module_version("cuda/10.0.130","default")
	module_version("python/3.6.4","default")
	module_version("singularity/3.0","default")
else
	module_version("boost/1.60.0","default")
	module_version("boost-mpi/1.60.0","default")
	module_version("imkl/11.3.4.258","default")
	module_version("intel/2016.4","default")
	module_version("openmpi/2.1.1","default")
	module_version("gcc/5.4.0","default")
	module_version("cuda/8.0.44","default")
	module_version("python/3.5.4","default")
	module_version("singularity/2.6","default")
end

-- shortcut versions
module_version("intel/2018.3","2018","18")
module_version("intel/2017.5","2017","17")
module_version("intel/2016.4","2016","16")
module_version("python/2.7.14","2.7","2")
module_version("python/3.5.4","3.5")
module_version("python/3.6.3","3.6")
module_version("python/3.7.0","3.7","3")
module_version("r/3.3.3","3.3","3")
module_version("imkl/11.3.4.258","11")
module_version("imkl/2017.4.239","2017.4","2017")
module_version("imkl/2018.3.222","2018.3","2018")
module_version("cuda/8.0.44","8.0","8")
module_version("cuda/9.0.176","9.0","9")
module_version("cuda/10.0.130","10.0","10")

-- module aliases
module_alias("allinea-cpu","ddt-cpu")
module_alias("allinea-gpu","ddt-gpu")
module_alias("arm-forge-cpu","ddt-cpu")
module_alias("arm-forge-gpu","ddt-gpu")

-- hidden versions
hide_version("parallel/20170622")
hide_version("parallel/20160722")
hide_version("boost/1.63.0")
hide_version("flex/2.5.39")
hide_version("python/3.5.2")
hide_version("python/2.7.13")
hide_version("python27-scipy-stack/2017a")
hide_version("python35-scipy-stack/2017a")
hide_version("python27-mpi4py/2.0.0")
hide_version("python35-mpi4py/2.0.0")
hide_version("caffe2/0.8.1")
hide_version("librt-compat/centos7")
hide_version("singularity/2.3")
hide_version("singularity/2.4")
hide_version("gentoo/2019")
hide_version("julia/0.5.1")
hide_version("julia/0.6.0")
hide_version("julia/0.6.2")
hide_version("julia/1.0.0")
--hide_version("cuda/10.0.130")
-- default versions for hidden deprecated modules,
-- where there is only one version per directory
module_version("python27-scipy-stack/2017a","default")
module_version("python35-scipy-stack/2017a","default")
module_version("python27-mpi4py/2.0.0","default")
module_version("python35-mpi4py/2.0.0","default")
module_version("caffe2/0.8.1","default")
