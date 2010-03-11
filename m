From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2 v2] ASoC: da7210: Add
 11025/22050/44100/88200 rate support
Date: Thu, 11 Mar 2010 10:56:29 +0000
Message-ID: <1268304989.3758.69.camel@odin>
References: <uy6hzh9c7.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id A63A5103902
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 11:56:36 +0100 (CET)
Received: by fxm20 with SMTP id 20so17322574fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 02:56:34 -0800 (PST)
In-Reply-To: <uy6hzh9c7.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Phil Edworthy <Phil.Edworthy@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-11 at 11:37 +0900, Kuninori Morimoto wrote:
> This driver USE PLL for 11025/22050/44100/88200 rate.
> To enable switching to bypass mode, PLL is always turned on.
> Special thanks to Phil
> 
> Signed-off-by: Phil Edworthy <Phil.Edworthy@renesas.com>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
