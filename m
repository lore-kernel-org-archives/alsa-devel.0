From: "Jie, Yang" <yang.jie@intel.com>
Subject: RE: [PATCH v2 2/2] ALSA: set no sound proc fs for reduced memory
 footprint
Date: Wed, 27 May 2015 05:38:01 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90553AED2@SHSMSX101.ccr.corp.intel.com>
References: <1432646037-23803-1-git-send-email-yang.jie@intel.com>
 <1432646037-23803-3-git-send-email-yang.jie@intel.com>
 <20150527044955.GB3096@sudip-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150527044955.GB3096@sudip-PC>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Zhang, Vivian" <vivian.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Sudip Mukherjee [mailto:sudipm.mukherjee@gmail.com]
> Sent: Wednesday, May 27, 2015 12:50 PM
> To: Jie, Yang
> Cc: tiwai@suse.de; broonie@kernel.org; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; Girdwood, Liam R; Zhang, Vivian
> Subject: Re: [PATCH v2 2/2] ALSA: set no sound proc fs for reduced memory
> footprint
> 
> On Tue, May 26, 2015 at 09:13:57PM +0800, Jie Yang wrote:
> > Disable sound proc fs, when CONFIG_SND_NO_PROC_FS is selected, which
> > can save about 9KB memory size for reducing memory footprint purpose.
> > ---
> missing Signed-off-by.
 
Thanks for pointing out.

Signed-off-by: Jie Yang <yang.jie@intel.com>

Takashi, do I need to resend them?

Thanks,
~Keyon

> 
> regards
> sudip
