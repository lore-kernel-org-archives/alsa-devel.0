From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: Envy24Control and wordclock
Date: Mon, 14 Jun 2004 10:40:30 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0406141035420.11603@kosh.hut.fi>
References: <E1BZea0-0003QE-M3@sc8-sf-list2.sourceforge.net> <40CD4D19.2080602@sun.ac.za>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40CD4D19.2080602@sun.ac.za>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ludwig Schwardt <schwardt@sun.ac.za>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Unfortunately I still couldn't sync the cards with the patched version
> (no word clock or S/PDIF syncing).

I've successfully synced 1010LT and Audiophile 2496 through S/PDIF, both
ways; 1010LT master, 2496 slave & 2496 master, 1010LT slave

The master sets its clock to eg. 96000 and the slave to S/PDIF. The
S/PDIF's must be connected of course with cable (master out->slave in)

Tommi


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
