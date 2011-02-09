From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: list *all* PCMs
Date: Wed, 9 Feb 2011 15:28:55 +0800
Message-ID: <AANLkTin7LCQKMSyJHS6wYLKvDTqaKG1wVEap_Uxbia4p@mail.gmail.com>
References: <AANLkTikfPkpxshmJRVd_iHdNNddrM7LOT0cn+oTLGgtX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A03A4103873
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 08:28:55 +0100 (CET)
Received: by ewy19 with SMTP id 19so3214888ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Feb 2011 23:28:55 -0800 (PST)
In-Reply-To: <AANLkTikfPkpxshmJRVd_iHdNNddrM7LOT0cn+oTLGgtX@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/2/9 Aleksandar Kostadinov <akostadinov@gmail.com>

> Hello,
>
> I searched through the list archive and I can't find a way to list all
> PCM devices. aplay/arecord -L show only these that have hint show on.
> Is there such command that lists all PCMs?
>

aplay -l
