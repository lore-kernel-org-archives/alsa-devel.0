From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Omnistudio USB further problem report
Date: Fri, 28 Jan 2005 19:23:53 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501281921130.8453-100000@studcom.urz.uni-halle.de>
References: <1106864615.308.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106864615.308.9.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rusty Phillips <rustyp@freeshell.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Rusty Phillips wrote:
> 2)  There are some strange initialization problems:

The Omnistudio has some quirks that are similar to the Quattro ones.
I made a patch after ALSA 1.0.8, so either get the current CVS or try
to replace four files in 1.0.8 with the files in
<http://www.informatik.uni-halle.de/~ladischc/usbmidi.tar.gz>.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
