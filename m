From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/4] ASoC: SAMSUNG: Move PCM specific
 definitions into pcm.c
Date: Fri, 7 Jan 2011 15:04:11 +0900
Message-ID: <AANLkTimhrUKyj9AFBE0taVoHbNj8tKnJg4=DCDCiCsdb@mail.gmail.com>
References: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
	<1294376243-18334-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7816910392C
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 07:04:11 +0100 (CET)
Received: by bwz10 with SMTP id 10so10168278bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Jan 2011 22:04:11 -0800 (PST)
In-Reply-To: <1294376243-18334-1-git-send-email-sw.youn@samsung.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 7, 2011 at 1:57 PM, Seungwhan Youn <sw.youn@samsung.com> wrote:
> This patch moves PCM specific definitions, they doesn't need to be
> shared, into 'pcm.c' from 'pcm.h'.
>
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Acked-by: Jassi Brar <jassi.brar@samsung.com>
