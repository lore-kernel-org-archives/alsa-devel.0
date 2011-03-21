From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: USB Quirks for Boss JS-8
Date: Mon, 21 Mar 2011 14:45:47 +0000
Message-ID: <201103211445.47752.maillist@superlative.org>
References: <201103181756.53155.maillist@superlative.org>
	<AANLkTikU+shHE6Z4cz0Gecy9VO6bg=Cxvpjywrfxfck5@mail.gmail.com>
	<4D875382.9000707@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 998CB2432D
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 15:45:51 +0100 (CET)
Received: by wwj40 with SMTP id 40so6028091wwj.20
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 07:45:51 -0700 (PDT)
In-Reply-To: <4D875382.9000707@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Monday 21 Mar 2011 13:32:50 Clemens Ladisch wrote:
 Try with
> audio interfaces 0 and 1 and MIDI interface 2.

Well, that was remarkably easy! I tried with these settings and it seems to 
work very well.

At first try (using Ardour with Jack) both input and output work. Many thanks 
for your help on this.

I'll test it a bit more and then work out out to submit as a patch.

Cheers,


-- 
Keith A. Milner
