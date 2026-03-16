Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9358F53D92
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:30:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 398F7601F9;
	Mon, 16 Mar 2026 21:30:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 398F7601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773693039;
	bh=TF+kB7i3hO50/o4abOx1MWTR48w+OC+jjUKtBt76tFU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qPnOtHFDTWt1hHPnABvFNY+NXUiQ5+jgTQrIKJeQsVxn5WyRjnFHxasVmdJd/Uz0p
	 NP+jc40sB0lmuKXKL6V2fMR4qQuAxA3YdaoDzP/VN/ebG1EjDsxMVJrGz0uZhGOy8m
	 6QWATYeiHvjexIq75m6N/+MFXNRwTHlImhsYsges=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B76DF80607; Mon, 16 Mar 2026 21:30:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 39DD4F80614;
	Mon, 16 Mar 2026 21:30:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75505F80535; Mon, 16 Mar 2026 21:30:03 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A0415F80495
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2026 21:30:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0415F80495
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189d6c6334387d00-webhooks-bot@alsa-project.org>
In-Reply-To: <189d6c63342cd800-webhooks-bot@alsa-project.org>
References: <189d6c63342cd800-webhooks-bot@alsa-project.org>
Subject: Accident
Date: Mon, 16 Mar 2026 21:30:03 +0100 (CET)
Message-ID-Hash: G5IWTVIBWIWCG42OTMB4LVLSJVDQHVLX
X-Message-ID-Hash: G5IWTVIBWIWCG42OTMB4LVLSJVDQHVLX
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G5IWTVIBWIWCG42OTMB4LVLSJVDQHVLX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #723 was edited from P-v-D:

My Bad

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/723
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
