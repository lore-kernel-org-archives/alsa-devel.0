From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: ALS300 support?
Date: Tue, 11 Nov 2003 15:11:38 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031111211138.GC10072@dbz.icequake.net>
References: <200311110951.23584.aw@gup.uni-linz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200311110951.23584.aw@gup.uni-linz.ac.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

On Tue, Nov 11, 2003 at 09:51:23AM +0100, Andreas Wasserbauer wrote:
> 
> I wonder if anyone is currently working on a driver for the Avance Logic (now 
> Realtek) ALS300(+) Chip.
> If yes: please give a hint where to find that piece of code, I'm in terrible 
> need for it.
> If not (well probably hard to answer for a single person): Does anybody know 
> where to get the specs of that particular rock, so I can start working on it?
> I found something like "could be, but isn't implemented yet" on the 
> soundcard-matrix of alsa, thus i suppose somebody has to have more detailed 
> informations...

Is that a sound/modem combination chip?  If so, I think the sound
component is the same as the ALS4000.  It may need some massaging to be
detected properly.  Realtek (the owner of ALS brand) is pretty nice
about providing documentation, so if you need further help with it I
would think about going there.

-- 
Ryan Underwood, <nemesis@icequake.net>


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
