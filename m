From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: support for PCI_DEVICE_ID_INTEL_ICH6_15
Date: Sat, 20 Nov 2004 14:37:09 -0500
Message-ID: <1100979429.6879.65.camel@krustophenia.net>
References: <419F7E9F.6040807@ens-lyon.fr>
	 <1100975509.6879.31.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100975509.6879.31.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brice.Goglin@ens-lyon.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-11-20 at 13:31 -0500, Lee Revell wrote:
> If this is the case "ICH 6 Family" is misleading, as this needs a
> completely different driver.

Sorry, rereading the posts from Intel, ICH6 == HD Audio, ICH5 is the
intel8x0 driver.

It looks like some ICH6 devices are claimed by the intel8x0 driver and
some by azx.  Sorry I can't help more, I don't have the hardware myself.

Lee





-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
