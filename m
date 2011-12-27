From: Daniel Mack <daniel@zonque.org>
Subject: Re: Driver Soudcard/Midi BCD2000 Behringer
Date: Tue, 27 Dec 2011 14:59:17 +0100
Message-ID: <CACTFLANirzU4xFdX6GOXh7+D-eRr5emfueBQnYyNJhqUJixeFg@mail.gmail.com>
References: <1324950800.13686.YahooMailNeo@web122307.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6BB77246E1
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2011 14:59:21 +0100 (CET)
Received: by dadv40 with SMTP id v40so1133691dad.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2011 05:59:17 -0800 (PST)
In-Reply-To: <1324950800.13686.YahooMailNeo@web122307.mail.ne1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: William Martins <wrmartins@ymail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Dec 27, 2011 2:53 AM, "William Martins" <wrmartins@ymail.com> wrote:
>
> Good evening Messrs. Developers,
> at times I'm trying to make this device work in linux (Behringer
BCD2000-), without success, that happens a few days I discovered that the
manufacturer built the same non-standard midi, so it is not recognized by
the kernel as a midi device.

Please send us the output of "lsusb -v" with the device plugged in.

Daniel
