From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Remove NEO1973(GTA01) audio
	driver
Date: Thu, 6 Jan 2011 10:23:20 +0900
Message-ID: <AANLkTik9u5ETmdbd3MrbJfdqEYguCdVvhA2225Uks2_4@mail.gmail.com>
References: <1294273308-25124-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CDFBF103827
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 02:23:20 +0100 (CET)
Received: by bwz10 with SMTP id 10so9158106bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 17:23:20 -0800 (PST)
In-Reply-To: <1294273308-25124-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, graeme.gregory@wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 6, 2011 at 9:21 AM, Seungwhan Youn <sw.youn@samsung.com> wrote:
> This patch remove to support NEO1973(GTA01) audio driver, because we
> don't need to support audio driver that is not supported in linux kernel.

Seems the board support never got submitted, though I see a few hints in the
ML archives. Assuming no such chances either in near future, I am for it.

'If anybody has any objections speak now or forever hold your peace' :)

Meanwhile,
Acked-by: Jassi Brar <jassi.brar@samsung.com>
