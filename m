From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Query about Playback device name
Date: Wed, 09 Mar 2011 15:22:16 +0100
Message-ID: <4D778D18.8070603@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB5681@EXGMBX01.sasken.com>,
	<4D776867.9040905@ladisch.de>
	<16F32A3F9AF4E441B752BCD79C151ACA69D0BB568D@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 7A27F243E6
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 15:20:53 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA69D0BB568D@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Irfan Shaikh wrote:
> I get following error on console if i use  plug:mcasp3  instead  plughw:0,0
> ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM mcasp3

Do aplay and your program run on same computer as the same user?


Regards,
Clemens
