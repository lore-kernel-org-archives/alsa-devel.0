From: David Lloyd <dmlloyd@tds.net>
Subject: Re: DMIX and capture stream
Date: Mon, 5 Jan 2004 11:27:57 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401051126560.8705@tomservo.workpc.tds.net>
References: <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
 <Pine.LNX.4.58.0401051020560.8705@tomservo.workpc.tds.net>
 <Pine.LNX.4.58.0401051725380.1862@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401051725380.1862@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Jan 2004, Jaroslav Kysela wrote:

> What's your problems? ALSA applications should offer you to set the
> playback and capture devices independently. If you bother with the OSS
> emulation, simply change the code in oss_dsp_open() -
> alsa-oss/alsa-oss.c. Perhaps, we can do it for you.

That is EXACTLY what I want.  Exactly!  And that is what I will try next, 
but if you want to do it it would be greatly appreciated.

- D


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
