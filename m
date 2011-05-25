From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix comment in cs4270 codec
 driver
Date: Wed, 25 May 2011 18:51:49 +0000
Message-ID: <BANLkTi=CDSPPX+H=YzcZuVDotQ18QQAAjw@mail.gmail.com>
References: <1306309992-3624-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BEE81037EA
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 20:51:55 +0200 (CEST)
In-Reply-To: <1306309992-3624-1-git-send-email-zonque@gmail.com>
Content-Language: en-US
Content-ID: <5FBC5727D056D044BACCF5E32758A4A2@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 25, 2011 at 2:53 AM, Daniel Mack <zonque@gmail.com> wrote:
> The comment does not reflect reality anymore since the multi-component
> monster patch landed. Things are matched by names now, and not by
> exporting and referencing a struct. Fix it to avoid confusion.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
