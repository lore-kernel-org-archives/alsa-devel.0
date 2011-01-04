From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Samsung: Debug register
Date: Tue, 04 Jan 2011 16:45:50 +0000
Message-ID: <1294159550.3490.351.camel@odin>
References: <1294019471-17044-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C0CC024469
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 17:45:53 +0100 (CET)
Received: by wwe15 with SMTP id 15so14390234wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 04 Jan 2011 08:45:53 -0800 (PST)
In-Reply-To: <1294019471-17044-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-03 at 10:51 +0900, Jassi Brar wrote:
> The DMA channel status is read from I2SCON register.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  sound/soc/samsung/i2s.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
