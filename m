From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: SB Live! 24-bit
Date: Fri, 10 Dec 2004 15:38:04 -0500
Message-ID: <1102711084.29919.32.camel@krustophenia.net>
References: <ea647236041210115033a6dcdf@mail.gmail.com>
	 <200412102132.44782.ketelaars@wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200412102132.44782.ketelaars@wanadoo.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frans Ketelaars <ketelaars@wanadoo.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-12-10 at 21:32 +0100, Frans Ketelaars wrote:
> Summary: alsa does not currently support the SB0410, but alsa drivers 
> are available if you are willing to compile your own kernel and 
> alsa-drivers.

You need to use ALSA CVS and the snd-ca0106 driver.  The "Audigy LS"
driver was the old name for it.

This was just checked into CVS so you should expect to hit some bugs.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
