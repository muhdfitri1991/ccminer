extern "C" {
#include "sph/sph_blake.h"
#include "sph/sph_bmw.h"
#include "sph/sph_groestl.h"
#include "sph/sph_skein.h"
#include "sph/sph_jh.h"
#include "sph/sph_keccak.h"
#include "sph/sph_luffa.h"
#include "sph/sph_cubehash.h"
#include "sph/sph_shavite.h"
#include "sph/sph_simd.h"
#include "sph/sph_echo.h"
}

#include "miner.h"
#include "cuda_helper.h"
#include "cuda_x11.h"

#include <stdio.h>
#include <memory.h>

static uint32_t *d_hash[MAX_GPUS];

/*
extern "C" void *Blake512(void *oHash, const void *iHash, const size_t len)
{
        sph_blake512_context ctx_blake;
        sph_blake512_init(&ctx_blake);
        sph_blake512 (&ctx_blake, iHash, len);
        sph_blake512_close (&ctx_blake, oHash);
}
extern "C" void *Bmw512(void *oHash, const void *iHash, const size_t len)
{
        sph_bmw512_context ctx_bmw;
        sph_bmw512_init(&ctx_bmw);
        sph_bmw512 (&ctx_bmw, iHash, len);
        sph_bmw512_close(&ctx_bmw, oHash);
}
extern "C" void *Groestl512(void *oHash, const void *iHash, const size_t len)
{
        sph_groestl512_context ctx_groestl;
        sph_groestl512_init(&ctx_groestl);
        sph_groestl512 (&ctx_groestl, iHash, len);
        sph_groestl512_close(&ctx_groestl, oHash);
}
extern "C" void *Skein512(void *oHash, const void *iHash, const size_t len)
{
        sph_skein512_context ctx_skein;
        sph_skein512_init(&ctx_skein);
        sph_skein512 (&ctx_skein, iHash, len);
        sph_skein512_close (&ctx_skein, oHash);
}
extern "C" void *Jh512(void *oHash, const void *iHash, const size_t len)
{
        sph_jh512_context ctx_jh;
        sph_jh512_init(&ctx_jh);
        sph_jh512 (&ctx_jh, iHash, len);
        sph_jh512_close(&ctx_jh, oHash);
}
extern "C" void *Keccak512(void *oHash, const void *iHash, const size_t len)
{
        sph_keccak512_context ctx_keccak;
        sph_keccak512_init(&ctx_keccak);
        sph_keccak512 (&ctx_keccak, iHash, len);
        sph_keccak512_close(&ctx_keccak, oHash);
}
extern "C" void *Luffa512(void *oHash, const void *iHash, const size_t len)
{
        sph_luffa512_context ctx_luffa1;
        sph_luffa512_init (&ctx_luffa1);
        sph_luffa512 (&ctx_luffa1, iHash, len);
        sph_luffa512_close (&ctx_luffa1, oHash);
}
extern "C" void *Cubehash512(void *oHash, const void *iHash, const size_t len)
{
        sph_cubehash512_context ctx_cubehash1;
        sph_cubehash512_init (&ctx_cubehash1);
        sph_cubehash512 (&ctx_cubehash1, iHash, len);
        sph_cubehash512_close(&ctx_cubehash1, oHash);
}
extern "C" void *Shavite512(void *oHash, const void *iHash, const size_t len)
{
        sph_shavite512_context ctx_shavite1;
        sph_shavite512_init (&ctx_shavite1);
        sph_shavite512 (&ctx_shavite1, iHash, len);
        sph_shavite512_close(&ctx_shavite1, oHash);
}
extern "C" void *Simd512(void *oHash, const void *iHash, const size_t len)
{
        sph_simd512_context     ctx_simd1;
        sph_simd512_init (&ctx_simd1);
        sph_simd512 (&ctx_simd1, iHash, len);
        sph_simd512_close(&ctx_simd1, oHash);
}
extern "C" void *Echo512(void *oHash, const void *iHash, const size_t len)
{
        sph_echo512_context     ctx_echo1;
        sph_echo512_init (&ctx_echo1);
        sph_echo512 (&ctx_echo1, iHash, len);
        sph_echo512_close(&ctx_echo1, oHash);
}
extern "C" void *fnHashX11K[] = {
	Blake512,
	Bmw512,
	Groestl512,
	Skein512,
	Jh512,
	Keccak512,
	Luffa512,
	Cubehash512,
	Shavite512,
	Simd512,
	Echo512,
};
*/

void processHash(void *oHash, const void *iHash, const int index, const size_t len)
{
	/*
	void (*hashX11k)(void *oHash, const void *iHash, const size_t len);
	hashX11k = fnHashX11K[index];
	(*hashX11k)(oHash, iHash, len);
	*/

      switch (index)
      {
      case 0:
        sph_blake512_context ctx_blake;

	sph_blake512_init(&ctx_blake);
	sph_blake512(&ctx_blake, iHash, 80);
	sph_blake512_close(&ctx_blake, oHash);
        break;
      case 1:
        sph_bmw512_context ctx_bmw;

        sph_bmw512_init(&ctx_bmw);
        sph_bmw512 (&ctx_bmw, iHash, len);
        sph_bmw512_close(&ctx_bmw, oHash);
         break;
      case 2:
        sph_groestl512_context ctx_groestl;

        sph_groestl512_init(&ctx_groestl);
        sph_groestl512 (&ctx_groestl, iHash, len);
        sph_groestl512_close(&ctx_groestl, oHash);
         break;
      case 3:
        sph_skein512_context ctx_skein;

        sph_skein512_init(&ctx_skein);
        sph_skein512 (&ctx_skein, iHash, len);
        sph_skein512_close (&ctx_skein, oHash);
         break;
      case 4:
        sph_jh512_context ctx_jh;

        sph_jh512_init(&ctx_jh);
        sph_jh512 (&ctx_jh, iHash, len);
        sph_jh512_close(&ctx_jh, oHash);
         break;
      case 5:
        sph_keccak512_context ctx_keccak;

        sph_keccak512_init(&ctx_keccak);
        sph_keccak512 (&ctx_keccak, iHash, len);
        sph_keccak512_close(&ctx_keccak, oHash);
         break;
      case 6:
        sph_luffa512_context ctx_luffa1;

        sph_luffa512_init (&ctx_luffa1);
        sph_luffa512 (&ctx_luffa1, iHash, len);
        sph_luffa512_close (&ctx_luffa1, oHash);
         break;
      case 7:
        sph_cubehash512_context ctx_cubehash1;

        sph_cubehash512_init (&ctx_cubehash1);
        sph_cubehash512 (&ctx_cubehash1, iHash, len);
        sph_cubehash512_close(&ctx_cubehash1, oHash);
         break;
      case 8:
        sph_shavite512_context ctx_shavite1;

        sph_shavite512_init (&ctx_shavite1);
        sph_shavite512 (&ctx_shavite1, iHash, len);
        sph_shavite512_close(&ctx_shavite1, oHash);
         break;
      case 9:
        sph_simd512_context ctx_simd1;

        sph_simd512_init (&ctx_simd1);
        sph_simd512 (&ctx_simd1, iHash, len);
        sph_simd512_close(&ctx_simd1, oHash);
         break;
      case 10:
        sph_echo512_context ctx_echo1;

        sph_echo512_init (&ctx_echo1);
        sph_echo512 (&ctx_echo1, iHash, len);
        sph_echo512_close(&ctx_echo1, oHash);
         break;
      }
}



// X11K CPU Hash
const void* memPool = NULL;

void x11khash(void *output, const void *input)
{
        const int HASHX11K_NUMBER_ITERATIONS = 64;
        const int HASHX11K_NUMBER_ALGOS = 11;

        if(memPool == NULL) {
                memPool = (void*) malloc(2 * 64 * 128);
        }

	uint32_t _ALIGN(64) hashA[16], hashB[16];
        //void * hashA = (void*) memPool + (thr_id * 128);
        //void * hashB = (void*) memPool + (thr_id * 128) + 64;

        // Iteration 0
        processHash(hashA, input, 0, 80);

        for(int i = 1; i < HASHX11K_NUMBER_ITERATIONS; i++) {
        	uint32_t * p = hashA;
                processHash(hashB, hashA, p[i] % HASHX11K_NUMBER_ALGOS, 64);

                memcpy(hashA, hashB, 64);
        }

        memcpy(output, hashA, 32);
}

//#define _DEBUG
#define _DEBUG_PREFIX "x11k"
#include "cuda_debug.cuh"

static bool init[MAX_GPUS] = { 0 };

extern void quark_blake512_cpu_hash_64(int thr_id, uint32_t threads, uint32_t startNounce, uint32_t *d_nonceVector, uint32_t *d_outputHash, int order);

extern "C" int scanhash_x11k(int thr_id, struct work* work, uint32_t max_nonce, unsigned long *hashes_done)
{
	uint32_t *pdata = work->data;
	uint32_t *ptarget = work->target;
	const uint32_t first_nonce = pdata[19];
	int intensity = (device_sm[device_map[thr_id]] >= 500 && !is_windows()) ? 20 : 19;
	uint32_t throughput = cuda_default_throughput(thr_id, 1U << intensity); // 19=256*256*8;
	//if (init[thr_id]) throughput = min(throughput, max_nonce - first_nonce);

	if (opt_benchmark)
		ptarget[7] = 0x5;

	if (!init[thr_id])
	{
		cudaSetDevice(device_map[thr_id]);
		if (opt_cudaschedule == -1 && gpu_threads == 1) {
			cudaDeviceReset();
			// reduce cpu usage
			cudaSetDeviceFlags(cudaDeviceScheduleBlockingSync);
			CUDA_LOG_ERROR();
		}
		gpulog(LOG_INFO, thr_id, "Intensity set to %g, %u cuda threads", throughput2intensity(throughput), throughput);

		quark_blake512_cpu_init(thr_id, throughput);
		quark_bmw512_cpu_init(thr_id, throughput);
		quark_groestl512_cpu_init(thr_id, throughput);
		quark_skein512_cpu_init(thr_id, throughput);
		quark_keccak512_cpu_init(thr_id, throughput);
		quark_jh512_cpu_init(thr_id, throughput);
		x11_luffaCubehash512_cpu_init(thr_id, throughput);
		x11_shavite512_cpu_init(thr_id, throughput);
		x11_echo512_cpu_init(thr_id, throughput);
		if (x11_simd512_cpu_init(thr_id, throughput) != 0) {
			return 0;
		}
		CUDA_CALL_OR_RET_X(cudaMalloc(&d_hash[thr_id], (size_t) 64 * throughput), 0);

		cuda_check_cpu_init(thr_id, throughput);

		init[thr_id] = true;
	}

	uint32_t endiandata[20];
	for (int k=0; k < 20; k++)
		be32enc(&endiandata[k], pdata[k]);

	quark_blake512_cpu_setBlock_80(thr_id, endiandata);
	cuda_check_cpu_setTarget(ptarget);

	do {
		int order = 0;

		// Hash with CUDA
		quark_blake512_cpu_hash_80(thr_id, throughput, pdata[19], d_hash[thr_id]);
		TRACE("blake  :");

		   for (int i = 1; i < 64; i++)
		   {
			uint32_t * p = d_hash[thr_id];
			switch (p[i] % 11)
			{

                        case 0:
                                quark_blake512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("blake  :");
                                break;
                        case 1:
                                quark_bmw512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("bmw    :");
                                break;
                        case 2:
                                quark_groestl512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("groestl:");
                                break;
                        case 3:
                                quark_skein512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("skein  :");
                                break;
                        case 4:
                                quark_jh512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("jh512  :");
                                break;
                        case 5:
                                quark_keccak512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("keccak :");
                                break;
                        case 6:
                                x11_luffa512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("luffa  :");
                                break;
                        case 7:
                                x11_cubehash512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("cube   :");
                                break;
                        case 8:
                                x11_shavite512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("shavite:");
                                break;
                        case 9:
                                x11_simd512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("simd   :");
                                break;
                        case 10:
                                x11_echo512_cpu_hash_64(thr_id, throughput, pdata[19], NULL, d_hash[thr_id], order++);
                                TRACE("echo   :");
                                break;
		    }
		}

		*hashes_done = pdata[19] - first_nonce + throughput;

		work->nonces[0] = cuda_check_hash(thr_id, throughput, pdata[19], d_hash[thr_id]);
		if (work->nonces[0] != UINT32_MAX)
		{
			const uint32_t Htarg = ptarget[7];
			uint32_t _ALIGN(64) vhash[8];
			be32enc(&endiandata[19], work->nonces[0]);
			x11khash(vhash, endiandata);

			if (vhash[7] <= Htarg && fulltest(vhash, ptarget)) {
				work->valid_nonces = 1;
				work_set_target_ratio(work, vhash);
				work->nonces[1] = cuda_check_hash_suppl(thr_id, throughput, pdata[19], d_hash[thr_id], 1);
				if (work->nonces[1] != 0) {
					be32enc(&endiandata[19], work->nonces[1]);
					x11khash(vhash, endiandata);
					bn_set_target_ratio(work, vhash, 1);
					work->valid_nonces++;
					pdata[19] = max(work->nonces[0], work->nonces[1]) + 1;
				} else {
					pdata[19] = work->nonces[0] + 1; // cursor
				}
				return work->valid_nonces;
			} else {
				gpu_increment_reject(thr_id);
				if (!opt_quiet)
				gpulog(LOG_WARNING, thr_id, "result for %08x does not validate on CPU!", work->nonces[0]);
				pdata[19] = work->nonces[0] + 1;
				continue;
			}
		}

		if ((uint64_t) throughput + pdata[19] >= max_nonce) {
			pdata[19] = max_nonce;
			break;
		}
		pdata[19] += throughput;

	} while (!work_restart[thr_id].restart);

	*hashes_done = pdata[19] - first_nonce;
	return 0;
}

// cleanup
extern "C" void free_x11k(int thr_id)
{
	if (!init[thr_id])
		return;

	cudaThreadSynchronize();

	cudaFree(d_hash[thr_id]);

	quark_blake512_cpu_free(thr_id);
	quark_groestl512_cpu_free(thr_id);
	x11_simd512_cpu_free(thr_id);

	cuda_check_cpu_free(thr_id);
	init[thr_id] = false;

	cudaDeviceSynchronize();
}