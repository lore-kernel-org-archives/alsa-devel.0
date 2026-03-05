Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A869EFCE5F
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2026 03:58:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F339602C6;
	Thu,  5 Mar 2026 04:58:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F339602C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772683127;
	bh=elMKCtlfR0TFjhbeEYrjV40bI4ekOfT7Lk9YBm/UXBc=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GdrIP7aXG1duJL31oAU+ZTTTOxUE//k7E05db+xzTq6xsb4HXufyuav21vNPNdrw+
	 i+Z7FaqNJmC21B8o2++v+AHhbYMlrf0zUY7mQosCpM6G7NqqCAYOALcs+CI53BJSX4
	 FHOHSswgodVviuWDkX45oj6Hla7r0GUHtKBAjk1s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38BEAF805E6; Thu,  5 Mar 2026 04:58:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50357F805F1;
	Thu,  5 Mar 2026 04:58:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8C24F8025A; Thu,  5 Mar 2026 04:57:55 +0100 (CET)
Received: from mailman (unknown [10.254.200.3])
	by alsa1.perex.cz (Postfix) with ESMTP id AB99EF8014E
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2026 04:57:55 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: USB-Audio: Motu: M6-HiFi.conf - m6 has only 4 outputs, not 6
From: aggregatebabyish@gmail.com
To: alsa-devel@alsa-project.org
Date: Thu, 05 Mar 2026 03:57:55 -0000
Message-ID: <177268307569.415.4189341981325329768@mailman>
In-Reply-To: <189170a7dcbeae00-webhooks-bot@alsa-project.org>
References: <189170a7dcbeae00-webhooks-bot@alsa-project.org>
User-Agent: HyperKitty on http://mailman.alsa-project.org/
Message-ID-Hash: 5IPOK7JUFM4GFMJ6UMVGAAXCIP3KWYAR
X-Message-ID-Hash: 5IPOK7JUFM4GFMJ6UMVGAAXCIP3KWYAR
X-MailFrom: aggregatebabyish@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5IPOK7JUFM4GFMJ6UMVGAAXCIP3KWYAR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I made use of the new toolset and put it to use in order to locate favorable SP indicators for my game; you can check it out here. https://fnaf-online.io
