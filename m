Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B9CC433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Nov 2021 12:30:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F8F316A4;
	Sun, 21 Nov 2021 13:29:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F8F316A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637497802;
	bh=Uu+b3R1stOvDxxEcjQIh0hCKxS6uaIl6MJtrHzbFvPk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gx44/c5O2so0cvx7YljhZUaHsFMnyHviNhKzNlZgfEKjaM+19DiC0VyuVSXdrQylP
	 wOUkH9QISSbYtDyATXQCncf2Z8ta8MiJ/Iq3mP2a9zQepCOlhcWqU0oJfgm732v2jK
	 5nod4VQDH67vnZFj1ADb0mfh4Wl4BIjlIa+HzWjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8772F80115;
	Sun, 21 Nov 2021 13:29:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39F70F804AC; Sun, 21 Nov 2021 13:28:53 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id EAA34F800E7
 for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2021 13:28:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAA34F800E7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1637497728037467003-webhooks-bot@alsa-project.org>
References: <1637497728037467003-webhooks-bot@alsa-project.org>
Subject: Where can I find alsa forum?
Message-Id: <20211121122853.39F70F804AC@alsa1.perex.cz>
Date: Sun, 21 Nov 2021 13:28:53 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #193 was edited from yangyunfei16:

Dear alsa developers:
Hello. I am a graduate student in the Institute of information engineering, Chinese Academy of Sciences. We are doing a project to investigate the use of this library by some programmers who use alsa for programming, so we want to ask if there are any websites or forums on which more programmers who use this library communicate and discuss, We want them to do a questionnaire later. Thank you very much for your help!

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/193
Repository URL: https://github.com/alsa-project/alsa-lib
