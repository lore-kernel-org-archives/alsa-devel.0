From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] ASoC: da7210: Add
 11025/22050/44100/88200 rate support
Date: Thu, 11 Mar 2010 11:02:18 +0000
Message-ID: <20100311110218.GE2585@rakim.wolfsonmicro.main>
References: <uy6hzh9c7.wl%morimoto.kuninori@renesas.com>
	<1268304989.3758.69.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A44BD103934
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 12:02:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268304989.3758.69.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Phil Edworthy <Phil.Edworthy@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 11, 2010 at 10:56:29AM +0000, Liam Girdwood wrote:
> On Thu, 2010-03-11 at 11:37 +0900, Kuninori Morimoto wrote:
> > This driver USE PLL for 11025/22050/44100/88200 rate.
> > To enable switching to bypass mode, PLL is always turned on.
> > Special thanks to Phil
> > 
> > Signed-off-by: Phil Edworthy <Phil.Edworthy@renesas.com>
> > Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.
