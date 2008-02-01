From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: Salsa-lib add snd_pcm_get_params
Date: Fri, 01 Feb 2008 15:20:41 +0100
Message-ID: <47A32AB9.7090306@parrot.com>
References: <loom.20080201T085922-521@post.gmane.org>
	<s5htzkt2eb7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from toronto.xi-lite.net (co203.xi-lite.net [149.6.83.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BEA024545
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 15:21:36 +0100 (CET)
In-Reply-To: <s5htzkt2eb7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 1 Feb 2008 09:03:59 +0000 (UTC),
> Matthieu CASTET wrote:
>> Hi,
>>
>> in 0.0.14, snd_pcm_get_params is missing.
>> Is is not even in the stub form in pcm_macros.h.
>>
>> Why this function is missing ?
> 
> Because I don't like that API :)
> 
But shouldn't salsa be close as possible to the alsa-lib API ?


Matthieu
