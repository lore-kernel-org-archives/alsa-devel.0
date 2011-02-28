From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v20 1/3] MFD: Wl1273 FM radio core: Add I2C IO
 functions.
Date: Mon, 28 Feb 2011 17:50:24 +0100
Message-ID: <20110228165023.GD5263@sortiz-mobl>
References: <1298890951-23339-1-git-send-email-matti.j.aaltonen@nokia.com>
 <1298890951-23339-2-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298890951-23339-2-git-send-email-matti.j.aaltonen@nokia.com>
Sender: linux-media-owner@vger.kernel.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, mchehab@redhat.com, hverkuil@xs4all.nl, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Matti,

On Mon, Feb 28, 2011 at 01:02:29PM +0200, Matti J. Aaltonen wrote:
> Add I2C IO functions.
> Change the IO operation from read to write in wl1273_fm_set_volume.
> Update the year of the copyright statement.
> Remove two unnecessary calls to i2c_set_clientdata.
Provided that you add a changelog relevant to the patch itself, and not to the
v1->v2 diff:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
