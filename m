From: "Andreas Kuckartz" <A.Kuckartz@ping.de>
Subject: Re: [Alsa-user] Re: Bugtracking system
Date: 23 Jan 2004 10:59:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <012b01c3e198$4ccb0d00$a501a8c0@computer2>
References: <Pine.LNX.4.44.0401210251440.30081-100000@sasami.anime.net> <01dc01c3e019$da571450$a501a8c0@computer2> <013e01c3e0db$5eb3d7d0$a501a8c0@computer2> <200401231545.41284.sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sam Vilain <sam@vilain.net>
Cc: alsa-user@lists.sourceforge.net, 	 <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Sam Vilain wrote:

> What about sub-sub-categories for attaching bugs to individual
> drivers?

That is not supported by Bugzilla. One possibility is to remove one level
and add something like "ALSA drivers" as a second separate top-level
Category with the main drivers as individual Components. I think that can
and should be done later when the use of bugzilla.kernel.org is established.

The Bugzilla administrator probably would hesitate to do that now before it
is known that the system is really used for ALSA bugtracking. (There is not
yet a single entry for the whole current "Alternate Trees" Category ...)

Cheers,
Andreas



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
