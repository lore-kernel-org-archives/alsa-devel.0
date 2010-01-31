From: Louise Hoffman <louise.hoffman@gmail.com>
Subject: Re:
	=?windows-1252?q?Warning/error_from_ALSA=92s_pcm=5Fm?=
	=?windows-1252?q?in=2Ec_example=2E_Possible_problem=3F?=
Date: Sun, 31 Jan 2010 21:41:30 +0100
Message-ID: <30c82f5f1001311241r4c683f22p9bcff1709301984b@mail.gmail.com>
References: <30c82f5f1001301151r6de4761fh9453829c1af85e15@mail.gmail.com>
	<alpine.LNX.2.00.1001310944330.25340@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id AC81124463
	for <alsa-devel@alsa-project.org>; Sun, 31 Jan 2010 21:41:31 +0100 (CET)
Received: by ewy21 with SMTP id 21so1624352ewy.22
	for <alsa-devel@alsa-project.org>; Sun, 31 Jan 2010 12:41:31 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1001310944330.25340@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> It was a bug in alsa-lib. I fixed it in patch bellow. Thank you for your
> report.

Cool. And that was the big one, you fixed there =)

Can you also patch pcm_min.c ?
