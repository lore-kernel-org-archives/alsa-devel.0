From: John covici <covici@ccs.covici.com>
Subject: Re: via8xxx invalid cur_ptr
Date: Tue, 8 Apr 2003 14:32:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16019.5558.657938.837444@ccs.covici.com>
References: <m3adf69tpq.fsf@ccs.covici.com>
	<s5hfzotq6x1.wl@alsa2.suse.de>
	<16018.64905.4784.752391@ccs.covici.com>
	<s5hel4dq67z.wl@alsa2.suse.de>
Reply-To: covici@ccs.covici.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hel4dq67z.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: covici@ccs.covici.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

on Tuesday 04/08/2003 Takashi Iwai(tiwai@suse.de) wrote
 > 
 > ehm, sorry i meant if you do NOT use via8233A.  please try hw:0,1 (or
 > /dev/adsp for oss).
 > 
 > anyway, for testing, aplay is suitable.  please check this first.
 > then try oss.
I am not sure what you are asking me to do -- none of the programs
seem to have a way to change the sound device -- could you explain?

What is hw:0,1 ?

Thanks.

 > 
 > also, please try the cvs version.  i changed a bit this driver since
 > 0.9.2.
 > 
 > 
 > Takashi

-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
