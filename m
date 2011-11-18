From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] RFC v2 for snd-usb endpoint logic
	rework
Date: Fri, 18 Nov 2011 21:08:35 +0100
Message-ID: <4EC6BB43.1070503@gmail.com>
References: <1321646744-13656-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9F61F2413B
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 21:08:48 +0100 (CET)
Received: by bkat8 with SMTP id t8so3834689bka.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 12:08:48 -0800 (PST)
In-Reply-To: <1321646744-13656-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

On 11/18/2011 09:05 PM, Daniel Mack wrote:
> This is v2 of the patch bulk I posted some weeks ago, which incoporates
> the points that were discussed. Thanks to everyone who commented and
> helped with sugesstions.
> 
> This version work really well here, but as last time, it needs a lot
> more testing. What's still missing are some cleanups and more
> documentation, I'll do that once the acutal content is agreed upon.
> 
> Patches should apply cleanly to the latest mainline git + Takashi's
> sound tree.

The gist has also been updated.

  https://gist.github.com/1168715
