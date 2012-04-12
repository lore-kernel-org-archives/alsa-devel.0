From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Thu, 12 Apr 2012 13:45:59 +0200
Message-ID: <4F86C077.50900@gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag7_qzPJq44havp=EbFVKud5VvKaOLJk0i0dM43X3urp9Q@mail.gmail.com>
	<CAFz=ag6pqhfOvxv_ScbxJFs6OEZt18GM+Dgs1KWQMG7mdZO21g@mail.gmail.com>
	<CACckToXJAJxGo-LSM3X-q=6Vo=-KzuE2Om9bgFiDnWPFNWmnSQ@mail.gmail.com>
	<4F8336CA.9060809@gmail.com>
	<CAFz=ag5SPYk4fycCjK9WR82Rx1oOxWFCwaND+eZhk=KD03DRZQ@mail.gmail.com>
	<4F859E85.5010509@gmail.com>
	<CAFz=ag5XTqckLnX=He8SX=Z7SouzU6EX-x1Tufw0W8PC_kYAhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E56342417D
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 13:46:02 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so1549717bkw.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2012 04:46:02 -0700 (PDT)
In-Reply-To: <CAFz=ag5XTqckLnX=He8SX=Z7SouzU6EX-x1Tufw0W8PC_kYAhA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, Grant Diffey <gdiffey@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12.04.2012 11:05, Felix Homann wrote:
> Hi,
> 
> 2012/4/11 Daniel Mack <zonque@gmail.com>:
>> Just refreshed my tree and the combined patch (gist). Could you give it
>> another shot?
> 
> I've just tested the new version and have not found any issues. Great
> work! Thank you very much!

Good news indeed. As Grant is also signalling green light, I'll post
version 7 of the patch series now.

> BTW, didn't you have a patch for switching to an external clock source
> on the FTUs? Maybe it would be useful for me to clean up the dirty
> hack I've got somewhere for the effects controls. (Don't hurry, it
> will take me a couple of weeks anyway due to time constraints)

Can't find it right now. But that should be comparatively easy to do in
a subsequent patch.


Thanks,
Daniel
