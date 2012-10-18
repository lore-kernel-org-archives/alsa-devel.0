From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: davinci: enable SRAM ping ping buffering on
 DA850
Date: Thu, 18 Oct 2012 11:18:00 -0400
Message-ID: <20121018151800.GB25164@beef>
References: <1349991229-32107-1-git-send-email-mporter@ti.com>
 <1349991229-32107-3-git-send-email-mporter@ti.com>
 <50784F2A.7080809@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50784F2A.7080809@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Alsa Devel List <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 12, 2012 at 07:11:06PM +0200, Sergei Shtylyov wrote:
> Hello.
> 
> On 11-10-2012 23:33, Matt Porter wrote:
> 
> >Passes the DA850 shared SRAM gen_pool to the McASP driver
> >and enables the ping-pong buffer DMA support.
> 
>    Here "ping-pong is correct but the subject have a typo.

Thanks.

Daniel: can you correct this when you squash these into your
series?

-Matt
