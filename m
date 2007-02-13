From: "Clemens Ladisch" <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-lib: enable dmix-ing and proper
 5.1 routing for USB audio devices
Date: Tue, 13 Feb 2007 14:14:14 +0100
Message-ID: <1171372454.22875.1174375553@webmail.messagingengine.com>
References: <ALOGGER1171354291.14@alsa-project.org>
	<m2ps8e2ojr.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <m2ps8e2ojr.fsf@vador.mandriva.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thierry Vignaud <tvignaud@mandriva.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud wrote:
> Clemens Ladisch <clemens@ladisch.de> writes:
> > files:       src/conf/cards/USB-Audio.conf
> > description:
> > enable dmix-ing and proper 5.1 routing for USB audio devices
> > 
> > add a configuration file for USB audio devices
> 
> err, don't you need sg like this:

Oops.
Fixed.


Thanks!
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
