From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 1/7] ak4114 - fix errors in output selector
 bits
Date: Wed, 23 Sep 2009 11:16:01 +0200
Message-ID: <4AB9E751.6090606@ivitera.com>
References: <1253132741-15688-1-git-send-email-pavel.hofman@ivitera.com>	<s5hpr9kwfqr.wl%tiwai@suse.de>
	<4AB7C810.7060402@ivitera.com> <s5h4oqwxfoq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id ED6B424553
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 11:15:40 +0200 (CEST)
In-Reply-To: <s5h4oqwxfoq.wl%tiwai@suse.de>
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
> At Mon, 21 Sep 2009 20:38:08 +0200,
>>
>> Do you have any idea when we can expect the changes to propagate to
>> http://git.alsa-project.org/?p=alsa-kmirror.git;a=summary so that people
>> can install using description in
>> http://alsa-project.org/main/index.php/GIT_Server#Occasional_Developers ?
> 
> Use sound-2.6.git tree on kernel.org together with alsa-driver-build.git
> tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
> 
> For casual developers, the snapshot tarball is available at:
>   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
> 
> 

Hi Takashi,

Thanks a lot for the info. Is this procedure a temporary, alternative,
or new preferred way of compiling alsa drivers from git, as opposed to
http://alsa-project.org/main/index.php/GIT_Server#Occasional_Developers?

Thanks,

Pavel.
