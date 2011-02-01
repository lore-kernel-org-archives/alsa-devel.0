From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH] ASoC: EDB93xx machine sound driver with
 CS4271
Date: Wed, 02 Feb 2011 02:58:15 +0300
Message-ID: <1296604695.1504.15.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward10.mail.yandex.net (forward10.mail.yandex.net
	[77.88.61.49]) by alsa0.perex.cz (Postfix) with ESMTP id B07EB103806
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 00:58:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: todorcolov@abv.bg
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Todor,

> Zdrastvuj Aleks,
> I'd like to test the sound module. Which is the latest patch versions
> and 
> coresponding kernel version? In which official kernel release do you
> plan to 
> merge it?

As I can conclude from list, you should see it in 2.6.39 and possibly
-next already. 75% of the driver has been merged already. All you have
to do to start testing is to add patch that I've just sent to the list
([PATCH] EDB93xx: Add support for CS4271 CODEC on  EDB93xx boards).

Best regards,
	Alexander.
