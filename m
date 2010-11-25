From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: Make SMDK WM8580 driver unloadable
Date: Thu, 25 Nov 2010 10:19:06 +0900
Message-ID: <AANLkTik9pf8udZuYH_2LSn9yDZ4H3XbJ3GpMVKxsMNjz@mail.gmail.com>
References: <1290619203-27875-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A282103B0E
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 02:19:07 +0100 (CET)
Received: by bwz8 with SMTP id 8so418076bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 17:19:06 -0800 (PST)
In-Reply-To: <1290619203-27875-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 25, 2010 at 2:20 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Supply a module exit function so that the driver can be unloaded.

Acked-by: Jassi Brar <jassi.brar@samsung.com>
