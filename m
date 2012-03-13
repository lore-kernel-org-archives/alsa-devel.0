From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] [PATCH 0/5] Add vmaster hook for HD-audio
 mute-LED controls
Date: Tue, 13 Mar 2012 18:09:04 +0100
Message-ID: <4F5F7F30.4080502@canonical.com>
References: <1331562530-16044-1-git-send-email-tiwai@suse.de>
	<4F5E0EDF.1090402@canonical.com> <s5hy5r53li9.wl%tiwai@suse.de>
	<s5hty1t3ixx.wl%tiwai@suse.de> <4F5E74BC.5020209@canonical.com>
	<s5hlin5m14q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id BA3E124337
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 18:09:07 +0100 (CET)
In-Reply-To: <s5hlin5m14q.wl%tiwai@suse.de>
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

On 03/13/2012 08:05 AM, Takashi Iwai wrote:
> At Mon, 12 Mar 2012 23:12:12 +0100,
>> It looks very good to me, thanks! I guess we'll need mic mute LED's
>> also, but that can come later.
>
> Which machines?  I know of OLPC, but we haven't implemented it for
> others, no?

I have asked around a little and so far it seems to be only Thinkpads, 
and they are generally controlled through ACPI.

Maybe the collective audience of this mailinglist knows of more machines...

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
