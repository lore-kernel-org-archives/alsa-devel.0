From: Frank Barknecht <fbar@footils.org>
Subject: Re: ALSA vs OSS: Some questions
Date: Mon, 7 Apr 2003 18:28:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030407162854.GD20285@fliwatut.scifi>
References: <20030407145029.GA19610@fliwatut.scifi> <Pine.LNX.4.44.0304071710240.32290-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304071710240.32290-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hallo,

Jaroslav Kysela hat gesagt: // Jaroslav Kysela wrote:
> OSS can handle more formats, of course. But, the main difference
> between ALSA and OSS is that OSS doesn't handle non-interleaved
> sample buffers at all in the mmap mode. 

I got another question here: Am I right to assume, that mmap mode is
used, because it is the most efficient or is there hardware, that
requires mmapped access?

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
