From: James Cameron <quozl@laptop.org>
Subject: Re: Sound not working after new kernel installed
Date: Thu, 15 Oct 2015 23:19:34 +1100
Message-ID: <20151015121934.GO27911@us.netrek.org>
References: <trinity-85f74570-9abc-486a-82c3-4f14c20d1ad0-1444825379497@3capp-webde-bs37>
 <s5htwpsil76.wl-tiwai@suse.de>
 <trinity-2e394fe8-112e-4d76-a697-d35c721e754b-1444907835112@3capp-webde-bs08>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zimbra.real-time.com (zimbra.real-time.com [63.170.91.9])
 by alsa0.perex.cz (Postfix) with ESMTP id F210626046B
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 14:19:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <trinity-2e394fe8-112e-4d76-a697-d35c721e754b-1444907835112@3capp-webde-bs08>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Simon Wolk <mistervertigo@web.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 15, 2015 at 01:17:15PM +0200, Simon Wolk wrote:
> The Kernel changed from 3.2.0 to 3.19.0 for me. By installing the
> 3.19. the sound stopped working.

Yes, Ubuntu kernels change like that, but you can easily run more
recent kernel versions, see Ubuntu Wiki page:

https://wiki.ubuntu.com/Kernel/MainlineBuilds

While you wait for help, you can install latest v4.2.3 built 3rd
October 2015.

You can also test kernels between 3.2 and 3.19, if you don't get any
other help.

-- 
James Cameron
http://quozl.linux.org.au/
