From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 02/15] soundwire: Add SoundWire bus type
Date: Wed, 13 Dec 2017 10:16:04 +0100
Message-ID: <20171213091604.GB6269@kroah.com>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <1512575231-4154-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512575231-4154-3-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 06, 2017 at 09:16:58PM +0530, Vinod Koul wrote:
> This adds the base SoundWire bus type, bus and driver registration.
> along with changes to module device table for new SoundWire
> device type.
> 
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Looks good:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
