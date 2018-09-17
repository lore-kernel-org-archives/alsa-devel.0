From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Documentation: soundwire: fix stream.rst markup warnings
Date: Mon, 17 Sep 2018 12:41:41 +0900
Message-ID: <b14e406b-0988-22d3-4d1f-6809c4d77610@sakamocchi.jp>
References: <8e1ec734-06b8-ba8a-fdca-3221ac134ea0@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e1ec734-06b8-ba8a-fdca-3221ac134ea0@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 17 2018 09:34, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc markup warnings in soundwire/stream.rst:
> 
> rc4/Documentation/driver-api/soundwire/stream.rst:177: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:203: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:248: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:277: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:304: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:328: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:352: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> rc4/Documentation/driver-api/soundwire/stream.rst:364: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> 
> Fixes: 89634f99a83e ("Documentation: soundwire: Add more documentation")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> Cc: Shreyas NC <shreyas.nc@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/driver-api/soundwire/stream.rst |    8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
