From: John Dey <jsdey@optonline.net>
Subject: Re: SIIG-USB SoundWave 7.1 Pro
Date: Thu, 30 Aug 2007 15:08:24 -0400
Message-ID: <60ee2ff701ef550e6ff62115561cd7d3@optonline.net>
References: <c7cc6a8720861b912811313bde81fb6b@optonline.net>
	<1188196692.12689.1207418219@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta1.srv.hcvlny.cv.net (mta1.srv.hcvlny.cv.net [167.206.4.196])
	by alsa0.perex.cz (Postfix) with ESMTP id B9E24103818
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 21:08:26 +0200 (CEST)
Received: from robo1.jsdey.com (ool-44c1fb41.dyn.optonline.net [68.193.251.65])
	by mta1.srv.hcvlny.cv.net
	(Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
	with ESMTP id <0JNL00LCFP60S8U0@mta1.srv.hcvlny.cv.net> for
	alsa-devel@alsa-project.org; Thu, 30 Aug 2007 15:08:25 -0400 (EDT)
In-reply-to: <1188196692.12689.1207418219@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Alsa Dev <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens,

Thanks for your response.  Before responding, I wanted to wait until my 
4 speakers arrived.  I've got them and connected them to the audio 
receiver as Front L R and Back L R.  An spdif optical cable is 
connected from the sound card list above to the audio receiver.  At 
your suggestion I ran the command "speaker-test -c 8".  Only Front L R 
spoke.

Any further suggestions would be greatly appreciated.

John
On Aug 27, 2007, at 2:38 AM, Clemens Ladisch wrote:

> John Dey wrote:
>> I have the above referenced sound card.  It is running on the latest
>> version of CCRMA x86.  Jack shows only stereo.  How do I configure so
>> that I can run 5 channels.
>
> Most cards support only 2,4,6,8 channels.
> Please try speaker-test.
>
>
> HTH
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
