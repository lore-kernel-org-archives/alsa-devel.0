From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Mon, 7 Apr 2003 18:45:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030407164548.GA13308@ulima.unil.ch>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch> <3E864424.6060707@cucumelo.org> <20030330144633.GA9474@ulima.unil.ch> <20030331114752.GA3187@wotan.suse.de> <20030404114623.GB9836@ulima.unil.ch> <20030407091749.GA7661@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030407091749.GA7661@wotan.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Dr. Werner Fink" <werner@suse.de>
Cc: Benny Sjostrand <gorm@cucumelo.org>, Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 07, 2003 at 11:17:49AM +0200, Dr. Werner Fink wrote:

> Please use mmap way ... see manaul page vdr-bistreamout.5 for more
> details.

Well, I didn't thought about it :-( I did try to use mmap, and you are
totally right, with this option, the error message are gone ;-)
Unfortunately all I can hear is a clicking sound (just like with a
direct connection with my DVB card) and with what I now know it's not a
problem with the bistreamout but with the cs46xx driver!!!

Same problem with ac3play,xine,mplayer...

So I am sorry for having looked for a false problem :-(

> You do not need a new card.

But only someone who could solve the SPDIF output of the cs46xx
driver...

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
