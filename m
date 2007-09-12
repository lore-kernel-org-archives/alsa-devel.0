From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ALSA changes in 2.6.23-rc6 for Intel HDA
Date: Wed, 12 Sep 2007 16:00:41 +0300
Message-ID: <200709121600.42015.maximlevitsky@gmail.com>
References: <9e4733910709110958h5756a50fi7540fe9d654d1557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 67AD910398A
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 15:02:08 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so294229ugf
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 06:02:07 -0700 (PDT)
In-Reply-To: <9e4733910709110958h5756a50fi7540fe9d654d1557@mail.gmail.com>
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

On Tuesday 11 September 2007 19:58:00 Jon Smirl wrote:
> The ALSA changes in 2.6.23-rc6 for Intel HDA made me change my volume
> from about 30% to 75% to get the same level of sound. Was this
> intentional?
> 
> My ALSA info is here.
> http://pastebin.ca/692226
> 


Hi,

First of all, what kernel do you compare to (which has  louder sound)
Then if you use headphones, maybe you plugged them in 'surround output'
Like center/LFE/side/surround.
Those outputs give much lower levers of sound.
Only Front HP and Line-out have special amp for headphones.


Best regards,
	Maxim Levitsky
