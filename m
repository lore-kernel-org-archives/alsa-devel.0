From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: set no sound proc fs for reduced memory
 footprint
Date: Wed, 27 May 2015 10:19:55 +0530
Message-ID: <20150527044955.GB3096@sudip-PC>
References: <1432646037-23803-1-git-send-email-yang.jie@intel.com>
 <1432646037-23803-3-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432646037-23803-3-git-send-email-yang.jie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com, vivian.zhang@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2015 at 09:13:57PM +0800, Jie Yang wrote:
> Disable sound proc fs, when CONFIG_SND_NO_PROC_FS is selected,
> which can save about 9KB memory size for reducing memory
> footprint purpose.
> ---
missing Signed-off-by.

regards
sudip
