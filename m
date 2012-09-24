From: Arnout Engelen <alsalist@bzzt.net>
Subject: Re: HD Audio with 'mute light'
Date: Mon, 24 Sep 2012 12:06:33 +0200
Message-ID: <20120924100633.GF2822@bzzt.net>
References: <20120922185411.GE2822@bzzt.net> <506015E3.1080605@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-5.concepts.nl (smtp-5.concepts.nl [213.197.30.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D3F026030A
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 12:06:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <506015E3.1080605@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 24, 2012 at 10:12:19AM +0200, David Henningsson wrote:
> >Attached is the codec info.
> 
> We generally recommend people to submit the entire alsa-info, rather
> than just the codec info (which, btw, was an empty attachment).

woops :)

> In particular; if you're having a thinkpad, the mute LED is controlled
> through thinkpad-acpi, and if you're having an HP, it's usually
> connected to the codec in a way hinted by BIOS. Given that you have
> a conexant codec, I'm guessing it's a thinkpad.

Thanks (also to Takashi) for this explanation. Indeed this is a ThinkPad
(W520). I'll look into thinkpad-acpi :)


Kind regards,

Arnout
