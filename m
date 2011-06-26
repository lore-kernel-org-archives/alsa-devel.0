From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH V3 1/4] ASoC: SAMSUNG: Move I2S common
	register definition
Date: Sun, 26 Jun 2011 12:44:43 +0530
Message-ID: <BANLkTik72hZkg9C=sBMm=BAiegnOKbAW5g@mail.gmail.com>
References: <1308555381-4419-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5AD812463A
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Jun 2011 09:14:44 +0200 (CEST)
Received: by bwa18 with SMTP id 18so705194bwa.38
	for <alsa-devel@alsa-project.org>; Sun, 26 Jun 2011 00:14:44 -0700 (PDT)
In-Reply-To: <1308555381-4419-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 1:06 PM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> I2S registers can be used for control idma.
> Previously, register is defined in i2s.c.
> For sharing the registers, It is moved to i2s-regs.h
>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>

Acked-by: Jassi brar <jassisinghbrar@gmail.com>
