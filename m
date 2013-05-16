From: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>
Subject: Re: [PATCH] Remove an obsolete macro in configure.in
Date: Thu, 16 May 2013 15:07:04 +0000
Message-ID: <89F8E4011FD7234ABFE48744E300CBC206AB6D63@041-DB3MPN1-092.041d.mgd.msft.net>
References: <1368693178-30659-1-git-send-email-olivier@trillion01.com>
 <s5hhai3jate.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from itc.alstom.com (as-smtp4.itc.alstom.com [159.245.16.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 47871261A4C
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 17:06:49 +0200 (CEST)
In-Reply-To: <s5hhai3jate.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "olivier@trillion01.com" <olivier@trillion01.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Sigh, automake should be renamed to automasochism...
>
> > Signed-off-by: Olivier Langlois <olivier@trillion01.com>
>
> Thanks, applied.
>
> BTW, at the next time, please specify which package to patch :)
>
Takashi,

I am not asking better than improve my patch submitting skill. Please explain exactly what was missing. I followed what is described at

http://www.alsa-project.org/main/index.php/GIT_Server

When you say package was missing, are you referring to 'my module' in:

git format-patch -s -n -p --subject-prefix="PATCH - my module" remotes/origin/master

and in this particular case should 'my module' be configure or alsa-lib or something else?

Thank you,
Olivier


________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may be privileged. If you are not a named recipient, please notify the sender immediately and do not disclose the contents to another person, use it for any purpose or store or copy the information in any medium.
