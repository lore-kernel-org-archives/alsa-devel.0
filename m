From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: RX1950: Enable Mic Jack during glue
 driver init
Date: Fri, 7 Jan 2011 10:36:00 +0900
Message-ID: <AANLkTimWe19FQ++Qf_zkX7eFgAXwKYzXjDgKu-4Qo+PE@mail.gmail.com>
References: <1294344949-30670-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id D1D09245AA
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 02:36:00 +0100 (CET)
Received: by bwz10 with SMTP id 10so10061616bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Jan 2011 17:36:00 -0800 (PST)
In-Reply-To: <1294344949-30670-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 7, 2011 at 5:15 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> Enable Mic Jack during glue driver init, otherwise capture will not work.

Acked-by: Jassi Brar <jassi.brar@samsung.com>
