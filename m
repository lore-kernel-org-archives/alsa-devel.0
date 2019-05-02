From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH v4 00/22] soundwire: code cleanup
Date: Thu, 2 May 2019 12:37:53 +0530
Message-ID: <20190502070753.GK3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190502055812.GG3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190502055812.GG3845@vkoul-mobl.Dlink>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com
List-Id: alsa-devel@alsa-project.org

On 02-05-19, 11:28, Vinod Koul wrote:
> On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> > SoundWire support will be provided in Linux with the Sound Open
> > Firmware (SOF) on Intel platforms. Before we start adding the missing
> > pieces, there are a number of warnings and style issues reported by
> > checkpatch, cppcheck and Coccinelle that need to be cleaned-up.
> 
> Applied all expect 2, 3, 6 and 22

Split 2, 3, 22, updated log for 6 and pushed

-- 
~Vinod
