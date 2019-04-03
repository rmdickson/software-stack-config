local ompiv=...
local cluster = os.getenv("CC_CLUSTER") or nil

if cluster == "beluga" then
	-- hack to disable OpenIB warnings on Beluga login nodes
	setenv("OMPI_MCA_btl_openib_if_exclude", "mlx5_bond_0")
	setenv("OMPI_MCA_btl_openib_warn_nonexistent_if", "0")
end

local posix = require "posix"
local slurmpaths = { "/opt/software/slurm/lib", "/opt/software/slurm/lib64",
                     "/opt/slurm/lib64" }
local slurmpath = nil
for i,v in ipairs(slurmpaths) do
	if posix.stat(pathJoin(v,"libslurm.so"),"type") == "link" then
		slurmpath = v
		break
	end
end

if ompiv ~= "3.1" then
	-- OpenMPI 3.1 does not need LD_LIBRARY_PATH any more
	if slurmpath and posix.stat(pathJoin(slurmpath,"libpmi.so"),"type") == "link" then
		prepend_path("LD_LIBRARY_PATH", slurmpath)
		-- below is so we can recover it after newgrp
		prepend_path("RSNT_LD_LIBRARY_PATH", slurmpath)
	end
end

if ompiv == "2.1" or ompiv == "2.0" then
	if os.getenv("RSNT_INTERCONNECT") == "omnipath" then
	        setenv("OMPI_MCA_mtl", "^mxm")
	        setenv("OMPI_MCA_pml", "^yalla,ucx")
	        setenv("OMPI_MCA_btl", "^openib")
	        setenv("OMPI_MCA_oob", "^ud")
	        setenv("OMPI_MCA_coll", "^fca,hcoll")
	else
		if ompiv == "2.1" and cluster == "beluga" then
			-- Beluga 2.1 behaves like 3.1, better performance.
			setenv("OMPI_MCA_mtl", "^mxm")
			setenv("OMPI_MCA_pml", "ucx")
			-- avoids error messages about multicast, needs investigation
			setenv("HCOLL_ENABLE_MCAST_ALL", "0")
		else
			setenv("OMPI_MCA_pml", "^ucx")
		end
	end
elseif  ompiv == "3.1" then
	local slurm_pmi = nil
	if slurmpath then
		if posix.stat(pathJoin(slurmpath,"slurm/mpi_pmix_v2.so"),"type") == "regular" then
			slurm_pmi = "pmix_v2"
		else
			slurm_pmi = "pmi2"
		end
		setenv("SLURM_MPI_TYPE", slurm_pmi)
		-- RSNT_SLURM_MPI_TYPE is set so we can recover SLURM_MPI_TYPE after salloc
		setenv("RSNT_SLURM_MPI_TYPE", slurm_pmi)
	end

	setenv("OMPI_MCA_mtl", "^mxm")

	if os.getenv("RSNT_INTERCONNECT") == "omnipath" then
	        setenv("OMPI_MCA_pml", "^ucx,yalla")
	        setenv("OMPI_MCA_btl", "^openib")
	        setenv("OMPI_MCA_oob", "^ud")
	        setenv("OMPI_MCA_coll", "^fca,hcoll")
	else
	        setenv("OMPI_MCA_pml", "^yalla")
		-- avoids error messages about multicast, needs investigation
		setenv("HCOLL_ENABLE_MCAST_ALL", "0")
	end
elseif ompiv == "1.6" or ompiv == "1.8" or ompiv == "1.10" then
	if os.getenv("RSNT_INTERCONNECT") == "omnipath" then
		setenv("OMPI_MCA_mtl", "^mxm")
		setenv("OMPI_MCA_pml", "^yalla")
	end
end


