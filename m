From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add machine driver for Visstrim_M10
 board.
Date: Mon, 07 Mar 2011 11:12:13 +0000
Message-ID: <1299496333.3377.18.camel@odin>
References: <1299484029-2446-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 45B5B10387F
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 12:12:18 +0100 (CET)
Received: by ywg4 with SMTP id 4so1865307ywg.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2011 03:12:17 -0800 (PST)
In-Reply-To: <1299484029-2446-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-03-07 at 08:47 +0100, Javier Martin wrote:
> Visstrim_M10 boards have an external tlcv320aic3205 codec
> attached to SSI1. This driver glues together both interfaces.
> External amplifier is not supported in this first version.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Acked-by: Liam Girdwood <lrg@ti.com>
